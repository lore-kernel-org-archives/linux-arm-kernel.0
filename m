From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 22 May 2013 16:04:44 +0200
Subject: [PATCH 9/9] arm: mvebu: switch internal register address at
 runtime if needed
In-Reply-To: <20130522152700.4dab10a1@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369132414-18959-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130522152700.4dab10a1@skate>
Message-ID: <20130522140444.GK2824@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 03:27:00PM +0200, Thomas Petazzoni wrote:
> Arnd, Olof, Jason, Andrew, Gregory,
> 
> (Taking the terrible freedom of doing some top-posting)
> 
> As the arm-soc and Marvell maintainers, would you mind having a look
> specifically at the below patch, and give your Acked-by or comments?
> 
> I believe the other 8 patches that come earlier in this series are
> relatively straightforward. However, this specific patch is a bit
> complex, and may raise some eye balls.
> 
> So rather than having the eye balls raised late in the development
> cycle, I'd like to have them raised now, so that if some comments are
> made, I have enough time to either discuss them and/or rework the code
> accordingly.
> 
> Before making comments, please also have a read to the cover letter of
> the patch series
> (http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/169701.html),
> which explains other details of why this solution is needed. The entire
> problem cannot be understood if you don't have a serious read at the
> commit log and the cover letter.

Hi Thomas

You gave a good explanation why the CP15 bit its needed, etc. I liked
the comment.

It might be worth cross posting both u-boot and barebox lists, since
they are somewhat involved as well. Are there any other boot loaders
used on 370 and XP.

What happens with future chips. 375 springs to mind. I assume its
Marvell bootloader will do the mapping before handing over to
Linux. Is it required to also set the bit in CP15? Are we setting off
down a road where all future Marvell chips which are compatible with
370/XP now need to set this bit?

How does this effect dove? It will get compiled into the same multi
arch kernel as 370/XP. I'm thinking about
arch/arm/include/debug/mvebu.S which might be shared. Dove is not
going to have this bit set. Kirkwood could also share this code, now
that the serial ports are all in the same location.

What does the ARM reference documentation say about this bit? Is its
meaning defined? Is there any danger when this bit is used for its
intended purpose?

	Andrew
