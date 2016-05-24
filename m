From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 May 2016 09:33:57 +0900
Subject: [PATCH v2 11/23] ARM: dts: armadillo800eva: Fix W=1 dtc warnings
In-Reply-To: <20160524001309.GA2477@verge.net.au>
References: <1463728214-13838-1-git-send-email-geert+renesas@glider.be>
 <1463728214-13838-12-git-send-email-geert+renesas@glider.be>
 <e0a1fbc1-ac95-2c79-65ed-d0328679bb8a@cogentembedded.com>
 <CAMuHMdXPhMToHhZggdKo=i65nS_mQT1o44YBd_Lz-B2Td3Jm9Q@mail.gmail.com>
 <20160524001309.GA2477@verge.net.au>
Message-ID: <20160524003356.GB2477@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 09:13:09AM +0900, Simon Horman wrote:
> On Mon, May 23, 2016 at 02:52:20PM +0200, Geert Uytterhoeven wrote:
> > On Fri, May 20, 2016 at 5:38 PM, Sergei Shtylyov
> > <sergei.shtylyov@cogentembedded.com> wrote:
> > > On 05/20/2016 10:10 AM, Geert Uytterhoeven wrote:
> > >> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> > >> Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
> > >> Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
> > >> Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
> > >> Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property
> > >> Warning (unit_address_vs_reg): Node /i2c at 2 has a unit name, but no reg property
> > >>
> > >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >> ---
> > >> v2:
> > >>   - No changes.
> > >> ---
> > >>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 12 ++++++------
> > >>  1 file changed, 6 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> > >> b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> > >> index 2c82dab2b6f45f9c..b3f0ac4b99bd5a3d 100644
> > >> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> > >> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> > >
> > > [...]
> > >>
> > >> @@ -127,7 +127,7 @@
> > >>                 };
> > >>         };
> > >>
> > >> -       i2c2: i2c at 2 {
> > >> +       i2c2: i2c2 {
> > >
> > >    Not "i2c-2" as in the other patches?
> > 
> > Oops... Thanks for noticing!
> > 
> > Simon: Do you want me to repost the whole series once again, or
> > can you fix this up while applying?
> 
> I'll just fix it up.
> No need to repost for this.

I have queued this up with the above hunk changed to the following.
Please check the resulting patch and let me know if I've messed things up
somehow.

@@ -127,7 +127,7 @@
 		};
 	};
 
-	i2c2: i2c at 2 {
+	i2c2: i2c-2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
