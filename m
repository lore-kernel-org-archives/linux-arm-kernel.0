From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 6 Jun 2011 17:01:06 +0530
Subject: [PATCH 2/3] davinci: dm6467/T EVM: pass reference clock rate to
	dm646x_init()
In-Reply-To: <4DEB7DD4.5050706@mvista.com>
References: <1307034677-27236-1-git-send-email-nsekhar@ti.com>
	<1307034677-27236-2-git-send-email-nsekhar@ti.com>
	<4DEB7DD4.5050706@mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D38344A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 05, 2011 at 18:30:04, Sergei Shtylyov wrote:
> Hello.
> 
> On 02-06-2011 21:11, Sekhar Nori wrote:
> 
> > From: Bob Dunlop<bob.dunlop@xyzzy.org.uk>
> 
> > The DM6467 and DM6467T EVMs use different reference clock
> > frequencies. This difference is currently supported by having
> > the SoC code call a public board routine which sets up the reference
> > clock frequency. This does not scale as more boards are added.
> 
> > Instead, pass the reference clock frequency as a parameter
> > to dm646x_init(). Boards which do not need the default reference
> > clock changed can pass NULL to this function.
> 
> > Signed-off-by: Bob Dunlop<bob.dunlop@xyzzy.org.uk>
> > Signed-off-by: Sekhar Nori<nsekhar@ti.com>
> > ---
> > I have marked Bob as the author of this patch since it is essentially
> > his idea. Hope he doesnt mind that :)
> 
>     I don't think you should ascribe *your* patch to Bob. There's 
> Suggested-by: line if you want to credit Bob.

Well, in this case I actually took a patch authored by Bob, split
it into two and moved around the code to other files. But there is
also code written by me included in this patch.

Bob, do you have an opinion on this? If not, I will go with what
Sergei is suggesting.

Thanks,
Sekhar
