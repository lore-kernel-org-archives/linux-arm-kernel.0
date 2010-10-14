From: thomas.nemeth@betatech.fr (Thomas Nemeth)
Date: Thu, 14 Oct 2010 09:59:20 +0200
Subject: mx31: external abort on non-linefetch (debugging suspend to RAM)
In-Reply-To: <AANLkTins2JeaetXfA37WgzH2He8hd2z2fKxrMkfxK4HQ@mail.gmail.com>
References: <201010121159.57222.thomas.nemeth@betatech.fr>
	<AANLkTins2JeaetXfA37WgzH2He8hd2z2fKxrMkfxK4HQ@mail.gmail.com>
Message-ID: <201010140959.20713.thomas.nemeth@betatech.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 14 octobre 2010, Xinyu Chen a ?crit?:
> On Tue, Oct 12, 2010 at 5:59 PM, Thomas Nemeth
>
> <thomas.nemeth@betatech.fr> wrote:
> > # insight -D ./iMX31-regs.defs -R CCMR
> > Unhandled fault: external abort on non-linefetch (0x008) at
> > 0x40000000 Bus error
> >
> > ? ?On the MX31ADS the result is the following one :
> > mx31# ./insight -D iMX31-regs.defs -R CCMR
> > CCMR: 0x074B097D
>
> Hi Thomas

    Hi !


> The exception is caused by you accessing the 0x40000000 which has
> been remapped as peripheral port memory in bootloader.

    I'll have a look at 0x40000000 mapping in uboot. However, CCMR
    is located at 0x53F80000 and that's what I ask mmap to remap.
    How can a map request of 0x53F80000 trying to access 0x40000000 ?

    Is it a symptom that can explain my problems with suspend-to-ram ?


> As it's mapped, you can not access it by non privileged user.

    You mean "from user land" (instead of "from kernel space") ?


> Please check the c15, c2, 4 coprocessor register settings in
> bootloader.
>
> Thanks!

    Thanks to you :)


Thomas.
-- 
Thomas Nemeth - Ing?nieur d'?tudes en Informatique Industrielle
? ? ? ? ? ? ? ? Industrial Computing Software Designer
BETAtech - 15, rue Apollo, Z.A. de Montredon, 31240, L'Union.
05 34 30 40 00 (standard) ?/ ?05 34 30 40 09 (ligne directe)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101014/6978eccc/attachment.sig>
