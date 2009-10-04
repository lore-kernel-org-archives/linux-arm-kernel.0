From: bgat@billgatliff.com (Bill Gatliff)
Date: Sun, 04 Oct 2009 13:34:41 -0500
Subject: [PATCH v1.0 2/4] TS72XX: Allow to override machine ID
In-Reply-To: <0kcmp6-75a.ln1@chipmunk.wormnet.eu>
References: <20091004011413.12578.89897.stgit@localhost.localdomain>	<20091004011424.12578.79467.stgit@localhost.localdomain>
	<0kcmp6-75a.ln1@chipmunk.wormnet.eu>
Message-ID: <4AC8EAC1.1050201@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Clouter wrote:
>
> [1] something I first saw on the NAS Buffolo site but then heavily 
> 	prompted by the orion5x Debian installer maintainers
>
>   

Yea, a lot of the IOP machines that use RedBoot have to do this junk 
too...  Like the N4100.  :(

I mean, I could "lie" and say that I'm an N2100.  In fact, that plus a 
big comment in the machine descriptor that says "the crappy bootloader 
for this board passes the wrong machine identifier, so we lie to it in 
order to bring the system up" might be a better way to deal with it than 
an out-of-mainline asm hack that keeps coming back to you with each 
kernel release.

Could you tolerate that, rmk?  Just one commented line in the machine 
descriptor that looks kind of strange?


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
