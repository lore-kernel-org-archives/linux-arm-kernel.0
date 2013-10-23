From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 23 Oct 2013 18:48:06 +0800
Subject: userspace firmware load fails with current linux-next
In-Reply-To: <20131023124333.356d0e15@ipc1.ka-ro>
References: <20131023110618.7bd07899@ipc1.ka-ro>
 <20131023182609.6646b5c0@tom-ThinkPad-T410>
 <20131023124333.356d0e15@ipc1.ka-ro>
Message-ID: <CACVXFVM0oUi0m8sGtRGX_VS6wouvo5=N7XN=s477290pzKKC2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 6:43 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:

> The patch as is produces a build error, because 'size' is only defined
> after the 'if' statement.

Sorry for that, :-)

>
> The modified patch below works for me.
>
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 5d818df..709d6f5 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -277,7 +277,7 @@ static ssize_t sysfs_write_file(struct file *file, const char __user *user_buf,
>         ssize_t len = min_t(size_t, count, PAGE_SIZE);
>         char *buf;
>
> -       if (sysfs_is_bin(of->sd)) {
> +       if (sysfs_is_bin(of->sd) && file_inode(file)->i_size) {
>                 loff_t size = file_inode(file)->i_size;
>
>                 if (size <= *ppos)

OK, thanks for your test, and will prepare a formal one later.


Thanks,
--
Ming Lei
