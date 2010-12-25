From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 25 Dec 2010 11:34:47 +0000
Subject: Bogus machine-type from bootloader
References: <BF43E57B-EE45-49B1-AE2A-96F8CBFD40FE@gmail.com>
Message-ID: <nf1hu7-if4.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Damjan Marion <damjan.marion@gmail.com> wrote:
> 
> Is there any "proper" way if fixing bogus machine type sent by 
> bootloader (ofcourse except fixing bootloader itself)?
>
Proper no, as the bootloader is the 'proper' way.

The kludge fix that many distro's seem to use (Debian for example):

http://www.digriz.org.uk/ts78xx/booting-woes#unrecognized.2BAC8-unsupported_machine_ID

In short, what it does is get the first two instructions of a booting 
kernel to load the correct machine ID into r1.  The example there is for 
0x0674 (1652), you can adjust it for your own needs.

Cook the kernel, run the 'fixup' script and you should be okay.

Cheers

-- 
Alexander Clouter
.sigmonster says: Androphobia:
                  	Fear of men.
