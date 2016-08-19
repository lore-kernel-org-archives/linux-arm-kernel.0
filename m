From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Aug 2016 11:29:45 +0100
Subject: Linux 4.7 and Jornada 720 (SA-1100)
In-Reply-To: <4Tcq736lIfmjNv8%gof@news.chmurka.net>
References: <4Tcq736lIfmjNv8%gof@news.chmurka.net>
Message-ID: <20160819102945.GK1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 02:05:26PM +0000, Adam Wysocki wrote:
> I don't know if this is a proper group, but maybe someone will help?
> 
> I have a problem running Linux 4.7 on Jornada 720 handheld PC. This 
> antique has a StrongARM SA-1100 CPU (ARMv4-based) and Windows CE 3.0 
> stored in ROM. There is also an utility called jlinexec.exe (from 
> JLime project which is now nearly-dead) that is able to boot Linux 
> kernel on this machine.

I don't have any SA1100 devices, I only have a couple of SA1110 Assabets.
I've just tested 4.8.0-rc2 there, and it boots, although cpufreq appears
a little unhappy.

Make sure you have "console=ttySA0,38400n8" or similar to get serial
console output - it needs to be a "ttySA" port, not "ttyS".

Same probably goes for "earlyprintk=serial,ttyS0,115200", although I've
no experience of earlyprintk myself.  However, if you're not even
getting the "Uncompressing Linux... done, booting the kernel." line,
that suggests the decompressor is not running, or is trying to access
the wrong serial port.  The decompressor tries to find the first serial
port out of serial 3, 1 and 2 which has been left enabled.

Hope this helps.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
