From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 19 Mar 2012 12:33:05 -0700
Subject: [PATCH v7 2/3] clk: introduce the common clock framework
In-Reply-To: <4F678561.3040105@codeaurora.org>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-3-git-send-email-mturquette@linaro.org>
 <4F6404C2.7000506@codeaurora.org>
 <CAJOA=zP1HHqBNS4V2dN=Q9oOcOErQj8W__fB_qRyZeNLBk7VJg@mail.gmail.com>
 <4F678561.3040105@codeaurora.org>
Message-ID: <CAJOA=zN2cSSpM92oRnW0RyU_ZzyoQ=jthc-fAkf-P3z37uWt7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 12:13 PM, Saravana Kannan
<skannan@codeaurora.org> wrote:
> I saw some responses from you over the weekend but not to mine. So, I
> assumed you were busy with other stuff and I started working on a patch on
> top of v7.

I only answer trivial emails on the weekend ;-)

> I will send that out if I get around to finishing it before you
> do. Hope that's alright with you.

I'm happy to for you to take a crack at it.  I don't know what your
implementation looks like, but here are a couple concerns I have:

1) if you're copying the data from the initializer over to the struct
clk then make sure you handle the __init data aspects of it properly

2) are the members of struct clk_hw visible to the rest of the world?
Are they modifiable (i.e., not const)?  This is undesirable.

Thanks,
Mike
