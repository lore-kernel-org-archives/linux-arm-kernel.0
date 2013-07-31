From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 31 Jul 2013 14:21:49 +0200
Subject: Defining schemas for Device Tree
In-Reply-To: <CAKON4OyQUcqw1RFcWj3uy0i2i+3UBB8fG1rPw6tcrMGDZ40y6g@mail.gmail.com>
References: <1706112.Xn49tiCSKF@thinkpad> <20130731113401.GM9858@sirena.org.uk>
 <CAKON4OyQUcqw1RFcWj3uy0i2i+3UBB8fG1rPw6tcrMGDZ40y6g@mail.gmail.com>
Message-ID: <2300415.ZNNddtVGav@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 of July 2013 08:01:54 jonsmirl at gmail.com wrote:
> On Wed, Jul 31, 2013 at 7:34 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Jul 30, 2013 at 07:23:36PM -0400, jonsmirl at gmail.com wrote:
> >> Uboot could be an issue but I don't think they are actually doing
> >> anything with FDTs yet, they are just talking about doing it.
> > 
> > Right, plus any other bootloaders that handle the DT in some way.  Those
> > that just copy the file through without looking at it aren't an issue
> > but I thought people were doing things like adding in properties for
> > serial numbers but perhaps that's less widespread than I'd thought and
> > it's not an issue.
> 
> uboot patches up the amount of RAM it finds into the FDT. It might
> patch up clock speed too, I don't remember. I haven't seen it add
> serial numbers but it might, not sure which serial numbers.
> 
> There has been talk for several years about turning uboot into a bunch
> of device drivers and using FDT to control it. Allwinner has done that
> with the fex implementation. The uboot work is still in the talking
> about it phase.

u-boot still does not have generic driver model or at least did not have when 
I last checked it not so long ago, so it seems like there is still long way to 
go for using FDT as source of information about hardware in u-boot.

barebox [1], aka u-boot-v2, might be closer to this approach (it might be 
already using it, but this needs to be checked) as it already has generic 
driver model and support for DT.

Best regards,
Tomasz

[1] http://barebox.org/
