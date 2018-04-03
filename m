From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Tue, 3 Apr 2018 19:24:11 +0300
Subject: [PATCH v2 1/6] spi: core: handle timeout error from transfer_one()
In-Reply-To: <20180403161824.GB11578@sirena.org.uk>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-2-ssuloev@orpaltech.com>
 <20180403155224.GA11578@sirena.org.uk>
 <c0476d75-821f-7a0d-3c3f-270304e7b032@orpaltech.com>
 <20180403161824.GB11578@sirena.org.uk>
Message-ID: <dad0ea81-2dd6-ccc3-a0c9-cf20ff195b7f@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2018 07:18 PM, Mark Brown wrote:
> On Tue, Apr 03, 2018 at 07:00:55PM +0300, Sergey Suloev wrote:
>> On 04/03/2018 06:52 PM, Mark Brown wrote:
>>> On Tue, Apr 03, 2018 at 06:29:00PM +0300, Sergey Suloev wrote:
>>>> As long as sun4i/sun6i SPI drivers have overriden the default
>>>> "wait for completion" procedure then we need to properly
>>>> handle -ETIMEDOUT error from transfer_one().
>>> Why is this connected to those drivers specifically?
>> These 2 drivers have their own "waiting" code and not using the code from
>> SPI core.
> Does this not apply to any other driver - why is this something we only
> have to do when these drivers do it?  That's what's setting off alarm
> bells.

sun4i/sun6i drivers have let's say "smart" waiting while SPI core uses a 
fixed interval to wait.

I can't say for every SPI driver in kernel, that's outside of my area of 
expertise.
