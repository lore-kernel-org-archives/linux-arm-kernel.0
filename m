From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 2 Mar 2014 07:14:51 +0200
Subject: [PATCHv4 4/7] hwspinlock/core: add common OF helpers
In-Reply-To: <52F92524.3080402@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-5-git-send-email-s-anna@ti.com>
 <CAJAp7Oi7wD+VsMAd37gT04yZ4TH4ygXFmheDhvmWuanUjpBmVQ@mail.gmail.com>
 <52F92524.3080402@ti.com>
Message-ID: <CAK=WgbY0wDtGCm71E8VXi2g5+VcGogHEy8jdekTRg8xtp6-3rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 9:14 PM, Suman Anna <s-anna@ti.com> wrote:
> On 02/07/2014 04:49 PM, Bjorn Andersson wrote:
>> It seems to be standard practice to pass the error value back to the
>> consumer, so you should
>> return ERR_PTR(ret); here instead of the NULL...
>
>
> I have modelled the return values in this function based on the return
> values in the existing hwspin_lock_request interfaces. I would need to
> change those functions as well.
>
> Ohad,
> Do you have any objections to the return code convention change?

Unless strictly needed, I prefer we don't switch to the ERR_PTR code
convention, as it reduces code readability and increases chances of
user bugs.

In our case, switching to ERR_PTR and friends seems only to optimize a
few error paths, and I'm not sure it's a big win over simplicity.

Thanks,
Ohad.
