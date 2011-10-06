From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 6 Oct 2011 18:14:18 +0100
Subject: [GIT PULL] Samsung devel-2 for v3.2
In-Reply-To: <20111006155701.GA1470@opensource.wolfsonmicro.com>
References: <002001cc80e5$3e497790$badc66b0$%kim@samsung.com>
	<20111002192950.GB1005@sirena.org.uk>
	<019201cc8293$7776a790$6663f6b0$%kim@samsung.com>
	<20111005165401.GA7155@opensource.wolfsonmicro.com>
	<20111005230516.GA30439@sirena.org.uk>
	<00e601cc83f1$3298e660$97cab320$%kim@samsung.com>
	<20111006155701.GA1470@opensource.wolfsonmicro.com>
Message-ID: <20111006171418.GA23532@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2011 at 04:57:01PM +0100, Mark Brown wrote:

> The bisect did end up pointing at the GPIO commits, the build errors
> were causing issues.  Not really made any further progress on this issue
> today, some other things came up.

So, I've been trying some other directions here.  What I'm seeing by
pulling devices out of my config is that if I enable the LCD power
control then the board fails to boot.  Also, the I2C controllers appear
to be non-functional - I'm getting timeouts waiting for the bus to
become free which halt the boot for long enough that it'd look like it
had crashed if all the devices came up (there's a lot of I2C devices
there).

I've not had time to actually drill down below that level but it did
occur to me that there may be a problem with the pinmux code?
