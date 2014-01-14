From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Jan 2014 10:59:31 +0000
Subject: AArch64 kernel image decompression
In-Reply-To: <201401140714.52400.arnd@arndb.de>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <e79fa209ffc4485d8cae87bae3daa656@BN1PR03MB220.namprd03.prod.outlook.com>
 <CAOesGMi_QY6z_3QSdAs-3JaEUufgymJg=kiqpb9D6RNNjZF5sA@mail.gmail.com>
 <201401140714.52400.arnd@arndb.de>
Message-ID: <20140114105930.GH15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 07:14:51AM +0100, Arnd Bergmann wrote:
> I thought we could already boot both zImage and vmlinux on arm32.

We can now do with zImage, but it requires a u-boot which supports the
bootz command.  All the platforms rigged up to my test system with the
exception of the LDP3430 all support bootz, and use it, and I notice
that new platforms such as the now released cubox-i and hummingboard
support bootz right from the start, since it's the only sensible way
to boot a multiplatform kernel with a dt blob.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
