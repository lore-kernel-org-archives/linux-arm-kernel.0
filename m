From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 26 Nov 2015 09:39:03 +0100
Subject: [PATCH 1/2] drivers: amba: properly handle devices with power
 domains
In-Reply-To: <20151125180953.GN8644@n2100.arm.linux.org.uk>
References: <1448456127-31842-1-git-send-email-m.szyprowski@samsung.com>
 <1448456289-31960-1-git-send-email-m.szyprowski@samsung.com>
 <20151125132458.GL8644@n2100.arm.linux.org.uk> <5655B8F6.1070104@samsung.com>
 <CAPDyKFqTqPijF+Lbq0+a-Gv8CyaAr13JvZPjUN1-GNL5i3-mAw@mail.gmail.com>
 <20151125180953.GN8644@n2100.arm.linux.org.uk>
Message-ID: <5656C527.8040804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-11-25 19:09, Russell King - ARM Linux wrote:
> On Wed, Nov 25, 2015 at 02:56:10PM +0100, Ulf Hansson wrote:
>> On 25 November 2015 at 14:34, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>> Is ignoring dev_pm_domain_attach() return value a solution for you?
>> That's probably better than nothing, but I wonder if it in practice
>> will have any effect?
> If the PM domain is down, then trying to tread the ID is likely to oops
> the kernel.

In my case kernel simply hangs (no single message, even when earlyprintk 
is enabled)
instead of oopsing, that's why I've submitted this patch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
