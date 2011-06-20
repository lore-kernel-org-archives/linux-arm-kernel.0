From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Mon, 20 Jun 2011 16:45:46 +0300
Subject: [PATCH 2/2] mfd/ab8500: Use kstrtoul_from_user
In-Reply-To: <1307393012-32582-2-git-send-email-peterhuewe@gmx.de>
References: <1307393012-32582-1-git-send-email-peterhuewe@gmx.de>
	<1307393012-32582-2-git-send-email-peterhuewe@gmx.de>
Message-ID: <BANLkTikKRVP4PW48YtR+mMMNsaxTDxoGtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NAK
You should use kstrtou8_from_user() and drop 0xff check as well.

Do NOT blindly replace strict_strtoul with kstrtoul.

On Mon, Jun 6, 2011 at 11:43 PM, Peter Huewe <peterhuewe@gmx.de> wrote:
> - ? ? ? err = strict_strtoul(buf, 0, &user_val);
> + ? ? ? err = kstrtoul_from_user(user_buf, count, 0, &user_val);
> ? ? ? ?if (err)
> - ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? ? ? ? ? return err;
> +
> ? ? ? ?if (user_val > 0xff) {
> ? ? ? ? ? ? ? ?dev_err(dev, "debugfs error input > 0xff\n");
> ? ? ? ? ? ? ? ?return -EINVAL;
