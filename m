From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 11 Dec 2009 14:01:57 +0000
Subject: [samsung-soc] CPUfreq Linux clock API question
In-Reply-To: <000b01ca7a68$6d5f4cb0$481de610$%majewski@samsung.com>
References: <000b01ca7a68$6d5f4cb0$481de610$%majewski@samsung.com>
Message-ID: <20091211140156.GC25806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2009 at 02:47:06PM +0100, Lukasz Majewski wrote:

> The clock API used at S3C64xx seems not to allow for setting rate of two
> clocks simultaneously (or am I wrong? :-) ). 

Yes, the Linux clock API doesn't support that.

> If this change would not be possible, then have anyone thought about the way
> to provide such functionality? 

Is it really needed?  The clock updates usually need to be serialised
anyway by virtue of having to update multiple registers.  If it is
required I could see doing something like have "start updates" and
"commit updates" calls which would allow updates to be batched.
