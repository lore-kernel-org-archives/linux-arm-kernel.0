From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Jun 2015 17:44:43 +0100
Subject: mx6 hdmi resolution behaviour
In-Reply-To: <CAOMZO5AbC8PCo7J7ovw4izPBK08UkDgKGG++d+9xty4GJ0SzKQ@mail.gmail.com>
References: <CAOMZO5AbC8PCo7J7ovw4izPBK08UkDgKGG++d+9xty4GJ0SzKQ@mail.gmail.com>
Message-ID: <20150623164443.GC7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 01:41:46PM -0300, Fabio Estevam wrote:
> Hi,
> 
> On a imx6q-cubox-i running 4.1 kernel I am getting 1920x1080 HDMI
> resolution if I boot the board with the HDMI cable connected.
> 
> If I boot it without the HDMI cable and then connect it afterwards,
> the resolution goes to only 1024 x 768 and the following IPU message
> is seen:

If you have no connected connectors, then you get 1024x768:

imx-drm display-subsystem: No connectors reported connected with modes
[drm] Cannot find any crtc or sizes - going 1024x768

as that's what DRM defaults to when it has no other timing information
available.

> [   16.310548] imx-ipuv3 2400000.ipu: videomode adapted for IPU restrictions

I don't see this message booting on a Hummingboard with HDMI
disconnected.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
