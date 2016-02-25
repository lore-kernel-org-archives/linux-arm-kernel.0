From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Thu, 25 Feb 2016 09:51:40 +0100
Subject: [PATCH 3/5] all: s390: move wrapper infrastructure to generic
 headers
In-Reply-To: <1456338854-14901-4-git-send-email-ynorov@caviumnetworks.com>
References: <1456338854-14901-1-git-send-email-ynorov@caviumnetworks.com>
 <1456338854-14901-4-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160225085140.GC3980@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 09:34:12PM +0300, Yury Norov wrote:
> diff --git a/include/linux/syscalls_structs.h b/include/linux/syscalls_structs.h
> new file mode 100644
> index 0000000..a920cbc
> --- /dev/null
> +++ b/include/linux/syscalls_structs.h
> @@ -0,0 +1,60 @@
> +#ifndef _LINUX_SYSCALL_STRUCTS_H
> +#define _LINUX_SYSCALL_STRUCTS_H
> +
> +struct epoll_event;
> +struct iattr;
> +struct inode;
> +struct iocb;
> +struct io_event;
> +struct iovec;
> +struct itimerspec;
> +struct itimerval;

This is not needed for s390, right? So might be worth a separate patch
which moves the forward declarations?
