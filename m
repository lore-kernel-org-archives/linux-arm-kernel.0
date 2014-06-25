From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Jun 2014 12:14:43 +0100
Subject: [PATCH v3 1/2] arm: dts: am4372: let boards access all nodes
 through phandles
In-Reply-To: <20140625014016.GA21616@saruman.home>
References: <1403547659-24558-1-git-send-email-balbi@ti.com>
 <1403547659-24558-2-git-send-email-balbi@ti.com>
 <CAL_JsqJx_DJqxpEJebi0Etfv5g7=eYje_53vd_44GykreA-rkQ@mail.gmail.com>
 <20140625014016.GA21616@saruman.home>
Message-ID: <20140625111443.GG14495@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 02:40:16AM +0100, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jun 24, 2014 at 04:11:48PM -0500, Rob Herring wrote:
> > On Mon, Jun 23, 2014 at 1:20 PM, Felipe Balbi <balbi@ti.com> wrote:
> > > by providing phandles to rtc, wdt, cpu and dispc nodes,
> > > boards can access them to add board-specific data.
> > 
> > Strictly speaking, you are adding labels, not phandles. You can do
> 
> heh, fair point. Easily editable when applying, though (?)
> 
> > phandles without using labels, but the syntax is not so obvious. I'd
> > tell you what it is but offhand I don't remember. :)
> 
> something along the lines of using the full path ?

Yup. The full path in braces:

	phandle-property = <&{/full/path/to/node@0xDEAD}>;

Mark.
