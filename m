From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 15 May 2014 13:22:43 -0700
Subject: [RFC PATCH 08/10] ARM: tegra124: Bind CAR to syscon device
In-Reply-To: <5375148E.6040905@wwwdotorg.org>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
 <1400113986-339-9-git-send-email-abrestic@chromium.org>
 <5375148E.6040905@wwwdotorg.org>
Message-ID: <CAL1qeaEKJ9F4cG-1N6fCMO0w1xR0S_sMnziHx4xhSj=NyQGWuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 12:25 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/14/2014 06:33 PM, Andrew Bresticker wrote:
>> The XUSB PHY driver will be accessing the CAR registers through the
>> syscon interface.
>
> I very strongly don't want to use the syscon concept on Tegra. Instead,
> I want only the CAR driver touching the CAR registers. If other drivers
> need some CAR registers manipulated, that should happen by that other
> driver calling some explicit semantic API in the CAR driver to do so.
> Take a look at how the Tegra SMMU and Tegra AHB driver communicate for
> an example.

Understood.  I'll fix that up for the next spin.
