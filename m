From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 18 Apr 2013 19:29:35 +0300
Subject: [RFC v1] regulator: core: introduce regulator chain locking scheme
In-Reply-To: <20130415164018.GA14064@sirena.org.uk>
References: <1366031015-17073-1-git-send-email-grygorii.strashko@ti.com>
 <1366031015-17073-2-git-send-email-grygorii.strashko@ti.com>
 <20130415155040.GD15837@opensource.wolfsonmicro.com>
 <516C2905.8000200@ti.com> <20130415164018.GA14064@sirena.org.uk>
Message-ID: <51701F6F.7070206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2013 07:40 PM, Mark Brown wrote:
> On Mon, Apr 15, 2013 at 07:21:25PM +0300, Andrii Tseglytskyi wrote:
>> On 04/15/2013 06:50 PM, Mark Brown wrote:
>>>> In addition, such locking scheme allows to have access to the supplier
>>>> regulator API from inside child's (consumer) regulator API.
>>> I've still not seen any use case articulated for doing this...
>> Use case is introduced in ABB series:
> Sorry, I meant any sensible use case.
Hi Mark,

Thanks for you comments. I'll split it to 3 patches:
- abstract locking out into helper functions;
- introduce regulator chain locking scheme
- allow reentrant calls into the regulator framework (with hope that is 
has future,
may be can enable/disable it through constraints)

I understand that Regulator FW is common and wide used and we should 
very careful here.

Regards,
- grygorii
