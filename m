From: horms@verge.net.au (Simon Horman)
Date: Mon, 8 Dec 2014 09:09:43 +0900
Subject: [PATCH v2] ARM: shmobile: dts: koelsch: Fix flash partition
 label and size
In-Reply-To: <CAMuHMdUMSioEew4UiH3y=qEDuGjG81uw73ajbGiPNSP_OtRkVQ@mail.gmail.com>
References: <1417746508-14557-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUMSioEew4UiH3y=qEDuGjG81uw73ajbGiPNSP_OtRkVQ@mail.gmail.com>
Message-ID: <20141208000942.GB7420@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 10:51:33AM +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 5, 2014 at 3:28 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > Update the size and names of flash partitions to match the
> > expectations of the loader which are as follows:
> >
> > "loader"---0x0000_0000-0x0008_0000 [loader program (readonly)]
> > "user"  ---0x0008_0000-0x0060_0000 [U-Boot + bootargs + dt + uImage (readonly)]
> > "flash" ---0x0060_0000-0x0400_0000 [filesystem and free (read/write)]
> >
> > ["user"'s assumed breakdown]
> > U-boot       (0x0008_0000-0x000c_0000) 256KiB
> > bootargs     (0x000c_0000-0x0010_0000) 256KiB
> > Device tree  (0x0010_0000-0x0014_0000) 256KiB
> > zImage       (0x0014_0000-0x0060_0000) 4.75MiB
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
