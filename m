From: maz@misterjones.org (Marc Zyngier)
Date: Tue, 04 May 2010 13:33:54 +0200
Subject: 2.6.34-rc6 regression: pcmcia no longer compiles
In-Reply-To: <20100504041448.GA2893@ucw.cz>
References: <20100504041448.GA2893@ucw.cz>
Message-ID: <c79eb84d24e70983f4422c89a35580ff@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 May 2010 06:14:48 +0200, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> -rc5 compiled ok with similar config.
> 
> Now I get:
> 
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      drivers/pcmcia/pcmcia_ioctl.o
> drivers/pcmcia/pcmcia_ioctl.c: In function 'ds_open':
> drivers/pcmcia/pcmcia_ioctl.c:714: error: 'struct <anonymous>' has no
> member named 'present'
> drivers/pcmcia/pcmcia_ioctl.c: In function 'ds_read':
> drivers/pcmcia/pcmcia_ioctl.c:773: error: 'struct <anonymous>' has no
> member named 'dead'
> drivers/pcmcia/pcmcia_ioctl.c: In function 'ds_ioctl':
> drivers/pcmcia/pcmcia_ioctl.c:841: error: 'struct <anonymous>' has no
> member named 'dead'
> make[2]: *** [drivers/pcmcia/pcmcia_ioctl.o] Error 1
> make[1]: *** [drivers/pcmcia] Error 2
> make: *** [drivers] Error 2

Does the attached patch fix it (compile-tested only)?

        M.
-- 
Who you jivin' with that Cosmik Debris?
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-pcmcia-fix-compilation-after-16bit-state-lockin" filename*1*="g-cha.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100504/757d0b59/attachment.el>
