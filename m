From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Dec 2014 10:38:30 +0000
Subject: [RFC PATCH 0/6] Those patches is used for dw_hdmi audio.
In-Reply-To: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20141215103830.GD11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 10:11:28AM +0800, Yakir Yang wrote:
> 
> rk3288 use Designware HDMI IP, Designware HDMI supports four interfaces to
> config hdmi audio(I2S, S/PDIF, Generic Parallel Audio, AHB Audio DMA), but
> rk3288 only support two ways to config hdmi audio(I2S, S/PDIF), So we take
> I2S as hdmi audio operation interfaces, and then treat hdmi audio as an
> standard ALSA devices(only got platback function).

There is no need for dw-hdmi audio to be implemented as an ASoC
device - as I've already sent patches to Andy with my ALSA driver
which has been around for the last two years, and works well, and
doesn't require any additional DT description.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
