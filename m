From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 Oct 2015 10:54:45 +0200
Subject: Undefined instruction error on Cortex A57 (aarch64) in init
 process
In-Reply-To: <CADTbHxpXCJZdK=iQc+FUxW27-vv1_kHXCeespDXR2fJ8UkfCCg@mail.gmail.com>
References: <CADTbHxpXCJZdK=iQc+FUxW27-vv1_kHXCeespDXR2fJ8UkfCCg@mail.gmail.com>
Message-ID: <1631431.E7IDbh3b5M@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 October 2015 13:02:46 Pankaj Jangra wrote:
> In android system, after system is running for long time say 10 hour,
> some time i am hitting below
> traces:
> 
>  init[1]: undefined instruction: pc=0000000000401624
> Code: 1a9f00c2 aa1703e0 2a1603e1 9400e1bf (6b1f001f)
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
> 
> 

Is it always the same address that causes the invalid instruction?
This is the main loop of the init process, so it clearly got executed
correctly before.

	Arnd
