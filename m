From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Jan 2015 14:53:12 +0100
Subject: [PATCH v3 0/9] ARM: sunxi: Support cpufreq on sun[457]i
In-Reply-To: <20150112091020.GA30908@lukather>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
 <20150112091020.GA30908@lukather>
Message-ID: <20150113135312.GX4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 10:10:20AM +0100, Maxime Ripard wrote:
> On Mon, Jan 12, 2015 at 12:34:00PM +0800, Chen-Yu Tsai wrote:
> > Hi,
> > 
> > This is v3 of the cpufreq support series for sunxi. The series has been
> > rebased onto the latest sunxi-next. I've dropped all the patches Maxime
> > merged. This includes "ARM: sunxi: Register cpufreq-dt for sun[45678]i"
> > which was merged but not published yet.
> > 
> > Individual changes since v2 are listed within each patch.
> > 
> > 
> > Original cover letter follows:
> > 
> > This series adds support cpufreq support for sun[457]i using cpufreq-dt.
> > This also supports passive cpu cooling (thermal throttling) using thermal
> > zones with the temperature sensor in the SoC.
> > 
> > The operating points for the supported platforms were taken from the
> > linux-sunxi FEX files repository. The majority of boards use the same
> > settings. Only with sun7i do we see slight variations, either disabling
> > some frequencies, or bumping up the voltage a bit. In either case this
> > can be done by limiting the constraints for the supply regulator, or 
> > overriding the OPP table in the board dts file.
> > 
> > On sun7i, there is an additional operating point not found in the FEX
> > files, 960 MHz @ 1.4V, which is the full speed setting in both u-boot-sunxi
> > and mainline u-boot.
> > 
> > The series has been tested on the 4 boards I have. With cpufreq active,
> > the effects are visible as a decrease in SoC internal temperature.
> > Stability for the operating points has been tested using:
> > 
> >   http://linux-sunxi.org/Hardware_Reliability_Tests#Reliability_of_cpufreq_voltage.2Ffrequency_settings
> > 
> > More real world usage feedback is appreciated. Thermal throttling hasn't
> > been tested much, due to not being able to generate enough load without
> > the GPU for the SoC to heat up. Also on sun4i, the temperature sensor
> > still hasn't been calibrated, so the readings are highly inaccurate.
> 
> Applied 2, 3, 6 and 8.

And I just applied 4, 5, 7 and 9.

Thanks! 

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/09ad7620/attachment.sig>
