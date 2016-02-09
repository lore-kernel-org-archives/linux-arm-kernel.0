From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Tue, 9 Feb 2016 21:33:21 +0100
Subject: [linux-sunxi] Re: [PATCH 11/11] arm64: dts: add Pine64 support
In-Reply-To: <CAGRGNgWTMVYExfWZceoY2UKVYq=3g6EnhYBqt9GOFk0Yh6j+4g@mail.gmail.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-12-git-send-email-andre.przywara@arm.com>
 <20160205090337.GB1139@lukather> <56B47391.1040709@arm.com>
 <CAGRGNgWTMVYExfWZceoY2UKVYq=3g6EnhYBqt9GOFk0Yh6j+4g@mail.gmail.com>
Message-ID: <20160209213321.7ab6beba@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 8 Feb 2016 11:55:43 +1100
Julian Calaby <julian.calaby@gmail.com> wrote:

> I believe that device tree overlays are the generally recommended method.

I agree. But last time I tried, the device tree compiler didn't 
support overlays - neither in Debian nor in the in-kernel dtc ("-@" is 
unsupported; last tried with linux-4.3-rc7). 

And even if you could compile them, the platform has to support specifying which 
overlays to use in the first place (for example as a Linux cmdline option). 

For example Beaglebone Black (TI Sitara) does. I don't know whether sunxi does.

Also, the overlay dts files are very different from normal dts files, see 
<http://www.patternagents.com/news/2015/01/29/devicetree-overlays.html>.

The original Linux device tree changeset patchset also introduced an in-kernel 
interface for loading/unloading of DT overlays at runtime. AFAIK, this is still 
not available to user space.

More info at <https://lwn.net/Articles/616859/>.

(I tried some 4 months ago - it wasn't integrated enough. 
 So now I just patch the main dts every time - which I probably shouldn't)

Regards,
   Danny
