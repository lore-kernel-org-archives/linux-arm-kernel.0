From: s-anna@ti.com (Suman Anna)
Date: Tue, 8 Jul 2014 10:22:38 -0500
Subject: [PATCHv5 03/15] hwspinlock/core: maintain a list of registered
 hwspinlock banks
In-Reply-To: <CAK=WgbaahqdmWRDMKtRhco4y5B-WBFYDHYs2cLM7NL=QhnhK2Q@mail.gmail.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
 <1398904476-26200-4-git-send-email-s-anna@ti.com>
 <CAK=WgbakGbTaYz+4K24aT3vyRkDYwPKCm6XrcJvH667NMMfTTA@mail.gmail.com>
 <53B47621.6090307@ti.com>
 <CAK=WgbYtJ7TGqvjG3VAPPD5tVXx9-jEJU3iKEStUMxOvD1v=LQ@mail.gmail.com>
 <53B592CE.2010001@ti.com>
 <CAK=WgbaahqdmWRDMKtRhco4y5B-WBFYDHYs2cLM7NL=QhnhK2Q@mail.gmail.com>
Message-ID: <53BC0CBE.4060608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On 07/04/2014 12:01 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Thu, Jul 3, 2014 at 8:28 PM, Suman Anna <s-anna@ti.com> wrote:
>> OK, but we would still require this function to lookup the registered
>> device from the controller-phandle to retrieve the base_id.
> 
> Can we retrieve the base_id from the parent DT node itself?

Yeah, it is possible using the of_hwspin_lock_get_base_id function added
in Patch8, once we convert the phandle to a device node. The platform
implementations would be using this function during the registration
phase to register the base id, and we have to do the DT parse/lookup
again in the core.

regards
Suman
