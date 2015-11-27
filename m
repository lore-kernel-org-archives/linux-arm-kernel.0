From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Nov 2015 16:59:24 +0100
Subject: [PATCH 1/1] kconfig: add CPU endian selection beconfig and
 leconfig
In-Reply-To: <1448567995-8784-2-git-send-email-sbranden@broadcom.com>
References: <1448567995-8784-1-git-send-email-sbranden@broadcom.com>
 <1448567995-8784-2-git-send-email-sbranden@broadcom.com>
Message-ID: <4689388.tNd2tB57aZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 November 2015 11:59:55 Scott Branden wrote:
> @@ -151,6 +159,8 @@ help:
>         @echo  '  kvmconfig       - Enable additional options for kvm guest kernel support'
>         @echo  '  xenconfig       - Enable additional options for xen dom0 and guest kernel support'
>         @echo  '  tinyconfig      - Configure the tiniest possible kernel'
> +       @echo  '  beconfig        - Update current config to use big endian CPU'
> +       @echo  '  leconfig        - Update current config to use little endian CPU'
>  
> 

Most architectures don't actually support picking the endianess, I think
it would be better to keep this architecture specific in some form. If we
limit it to ARM/ARM64, we might not need the leconfig target at all, because
that is the default for all defconfig files in the kernel aside from ixp4xx,
which we can probably ignore here.

	Arnd
