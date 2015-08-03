From: ian.campbell@citrix.com (Ian Campbell)
Date: Mon, 3 Aug 2015 17:03:59 +0100
Subject: [PATCH v4] dtb: Create a common home for cross-architecture
 dtsi files.
In-Reply-To: <CAL_JsqLU_CMaYN=FpVdeenVYgvBNDUQsqvi=uwuENOk=pt0WZQ@mail.gmail.com>
References: <1438592111-8471-1-git-send-email-ian.campbell@citrix.com>
 <CAL_JsqLU_CMaYN=FpVdeenVYgvBNDUQsqvi=uwuENOk=pt0WZQ@mail.gmail.com>
Message-ID: <1438617839.31129.30.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-08-03 at 10:55 -0500, Rob Herring wrote:
> On Mon, Aug 3, 2015 at 3:55 AM, Ian Campbell <ian.campbell@citrix.com> 
> wrote:
> > Commit 9ccd608070b6 ("arm64: dts: add device tree for ARM SMM-A53x2 on
> > LogicTile Express 20MG") added a new dts file to arch/arm64 which
> > included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
> > .dtsi supplied by arch/arm.
> > 
> > Unfortunately this causes some issues for the split device tree
> > repository[0], since things get moved around there. In that context
> > the new .dts ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
> > while the include is at src/arm/vexpress-v2m-rs1.dtsi.
> > 
> > The sharing of the .dtsi is legitimate since the baseboard is the same
> > for various vexpress systems whatever processor they use.
> > 
> > Rather than using ../../ tricks to pickup .dtsi files from another
> > arch this patch creates a new directory kernel/dts as a home for such
> > cross-arch .dtsi files, arranges for it to be in the include path when
> > the .dts files are processed by cpp and switches the .dts files to use
> > cpp #include instead of /include/. The dtsi file itself is moved into
> > a vendor subdir in this case "arm" (the vendor, not the ARCH=).
> 
> Sigh, it was not the include path I was referring to being wrong
> although that was too. It was the part about using #include instead of
> /include/.

Damn, how did I miss that!

v5 coming up, sorry :-/
