From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Mon, 22 Dec 2014 14:08:44 +0000
Subject: [PATCH v3 2/5] ASoC: dwc: Iterate over all channels
In-Reply-To: <20141222135301.GQ17800@sirena.org.uk>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <67cea1f0a74c333ec2048c7796cda37302d45e95.1418826016.git.Andrew.Jackson@arm.com>
 <20141222135301.GQ17800@sirena.org.uk>
Message-ID: <549825EC.80505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/14 13:53, Mark Brown wrote:
> On Fri, Dec 19, 2014 at 04:18:06PM +0000, Andrew Jackson wrote:
> 
>> The Designware core can be configured with up to four stereo channels.
>> Each stereo channel is individually configured so, when the driver's
>> hw_params call is made, each requested stereo channel has to be
>> programmed.
> 
> This is quite unclear to someone who doesn't know the hardware, is this
> a bug fix or a new feature?  It looks like it's a fix...
> 

It is a fix.  In the Designware core, each stereo channel is configured
individually.  So, when hw_params is called to configure N channels, 
N/2 stereo channels need to be configured in the core.  The existing
code doesn't do this and will only configure the highest numbered 
channel.

    Andrew
