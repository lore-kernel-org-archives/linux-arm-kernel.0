From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 20 Jan 2017 14:42:45 +0000
Subject: [PATCH] arm64: defconfig: disable CONFIG_DEVMEM
In-Reply-To: <20170119094917.GA11954@arm.com>
References: <20170113113734.16524-1-leif.lindholm@linaro.org>
 <20170113114801.GD3253@arm.com>
 <20170115124254.GF25883@bivouac.eciton.net>
 <CAF7UmSxMqKodEZfqheRsJxsM_R1yZHJaXMnyLyJwqULRz1xH=A@mail.gmail.com>
 <20170119094917.GA11954@arm.com>
Message-ID: <20170120144245.GG25883@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 09:49:17AM +0000, Will Deacon wrote:
> On Wed, Jan 18, 2017 at 05:58:05PM +0000, Leif Lindholm wrote:
> > On 15 January 2017 at 12:42, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> > > On Fri, Jan 13, 2017 at 11:48:01AM +0000, Will Deacon wrote:
> > >> On Fri, Jan 13, 2017 at 11:37:34AM +0000, Leif Lindholm wrote:
> > >> > /dev/mem is the opposite of what an operating system is for.
> > >> > Additionally, on arm* it opens up for denial-of-service attacks from
> > >> > userspace. So leave it disabled by default, requiring people who need
> > >> > it to enable it explicitly.
> > >>
> > >> I really like the idea, but are we sure that nothing common breaks without
> > >> this? For example, does Debian still boot nicely with this patch applied?
> > >
> > > Getting distros to not have to shop around for config fragments in
> > > order to be able to a stable system is one of my main purposes of this
> > > patch.
> > >
> > > Since Debian just published a 4.9 kernel, I gave that a spin (both DT
> > > and ACPI). No issues.
> > 
> > Will, any comments?
> 
> Nope; fine by me. arm-soc usually pick these up.

Arnd, Olof?

> FWIW, I did do a Debian CodeSearch for /dev/mem and there were more hits
> than I was hoping for. However, much of the code looked either:
> 
>  (a) Broken anyway
>  (b) Not relevant to arm64
>  (c) /dev/mem was just a string in a comment or something
> 
> There are a couple of crazy projects that appear to use /dev/mem to
> implement a heap, but I really couldn't figure out how that worked.

Yeah, I noticed those too.
I don't think they do.

/
    Leif
