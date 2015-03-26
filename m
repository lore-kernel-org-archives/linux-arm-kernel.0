From: dtor@google.com (Dmitry Torokhov)
Date: Thu, 26 Mar 2015 16:07:07 -0700
Subject: [PATCH 1/3] phy: core: Add devm_of_phy_get_by_index to phy-core
In-Reply-To: <55134D10.2070805@broadcom.com>
References: <1426885630-32429-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1426885630-32429-2-git-send-email-arun.ramamurthy@broadcom.com>
 <20150320212645.GA25405@dtor-ws> <550C9134.9020003@broadcom.com>
 <551330B5.6030901@ti.com> <55134D10.2070805@broadcom.com>
Message-ID: <20150326230707.GB18887@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 05:04:32PM -0700, Arun Ramamurthy wrote:
> 
> 
> On 15-03-25 03:03 PM, Kishon Vijay Abraham I wrote:
> >Hi,
> >
> >On Saturday 21 March 2015 02:59 AM, Arun Ramamurthy wrote:
> >>
> >>
> >>On 15-03-20 02:26 PM, Dmitry Torokhov wrote:
> >>>Hi Arun,
> >>>
> >>>On Fri, Mar 20, 2015 at 02:07:08PM -0700, Arun Ramamurthy wrote:
> >>>>Adding devm_of_phy_get_by_index to get phys by supplying an index
> >>>>and not a phy name when multiple phys are declared
> >
> >I think a bit more explanation on why get_by_index is needed here.
> Thanks Kison. Can you be more specific? I am unsure of what more I
> can explain here.

We just need to mention that some generic drivers, such as ehci, may use
multiple phys, and for such drivers referencing phy(s) by name(s) does
not make sense. Instead of inventing elaborate naming schemes and
producing custom code to iterate over names, such drivers are better of
using nameless phy bindings and using this newly introduced API to
iterate through them.

Thanks.

-- 
Dmitry
