From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 12:29:51 +0000
Subject: [version 2]  amba uarts - arm type uarts fifo size provided by
 device tree
In-Reply-To: <54FD912F.8080403@linaro.org>
References: <1424290069-8760-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20150303165534.GB10239@leverpostej> <54FD912F.8080403@linaro.org>
Message-ID: <20150309122951.GK8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 08:25:19AM -0400, Jorge Ramirez-Ortiz wrote:
> I just confirmed that there are a number of differences on top of the
> fifo size requiring many additional software changes.
> This is not great news since the uart announces itself as vendor_arm
> version 1.

And that is a _very_ bad thing.  The IP is claiming to be created by ARM,
but it isn't - that probably puts this PL011 in a sticky situation from a
legal point of view.  (We've had a CPU which identified itself as an ARM
Ltd ARM926, but it wasn't - the silicon vendor was forced to re-spin their
silicon to change the ID... I wouldn't be surprised if that happens here
too.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
