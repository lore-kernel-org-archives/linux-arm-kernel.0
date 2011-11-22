From: robherring2@gmail.com (Rob Herring)
Date: Tue, 22 Nov 2011 17:34:52 -0600
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111122222135.GB7845@gallagher>
References: <20111122192741.GG30583@opensource.wolfsonmicro.com>
 <20111122193124.GB9581@n2100.arm.linux.org.uk>
 <20111122193957.GH30583@opensource.wolfsonmicro.com>
 <20111122222135.GB7845@gallagher>
Message-ID: <4ECC319C.20409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2011 04:21 PM, Jamie Iles wrote:
> Hi Mark,
> 
> On Tue, Nov 22, 2011 at 07:39:57PM +0000, Mark Brown wrote:
>> On Tue, Nov 22, 2011 at 07:31:24PM +0000, Russell King - ARM Linux wrote:
>>> On Tue, Nov 22, 2011 at 07:27:41PM +0000, Mark Brown wrote:
>>
>>>> I've verified that this was introduced in the Russell's for-next, and
>>>> bisection of that branch tells me that the offending commit is "ARM:
>>>> vic: device tree binding" though an attempt to revert that in -next
>>>> failed.  This is especially surprising as I have USE_OF turned off, I'm
>>
>>> Thanks for the report.  I'll hold off pushing this stuff into the
>>> devel-stable branch while Jamie looks into this so that we can fix
>>> it and avoid having a bisection failure in this set of commits.
>>
>> Thanks.  Note that I'm not 100% sure I believe the bisection result as
>> reverting didn't fix the issue and I've stared at the code a bit without
>> seeing anything that set off alarm bells.
> 
> No, you're right - this is the offending commit.  It actually needs 
> this[1] fix and things should be okay.
> 
> Thomas, Rob, would one of you be able to apply this please?  I'm not 
> sure if this would normally go through Grant or not.
> 

I think it should go thru Thomas or have his ack if not.

Rob
