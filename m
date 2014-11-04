From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 4 Nov 2014 11:37:30 +0000
Subject: [PATCH 05/10] arm64: Convert dts to use reserved-memory nodes
In-Reply-To: <CAL_Jsq+V_tLkfwBKDQOOrkKtHWaRD5e1AHzbciwVYFYbpsAE=w@mail.gmail.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <411296ab915959b862923d827e730a1db2ff9b4e.1414099246.git.geoff@infradead.org>
 <20141024105111.GD24265@leverpostej>
 <CACxGe6szzOXHkK9ukpcSBZgeyy5AgX3+7PgQseBnB9XWYLj-PQ@mail.gmail.com>
 <20141024122738.GH24265@leverpostej> <1414799092.23621.48.camel@smoke>
 <CAL_Jsq+V_tLkfwBKDQOOrkKtHWaRD5e1AHzbciwVYFYbpsAE=w@mail.gmail.com>
Message-ID: <CACxGe6tWnM6OhAaoYpHdPxbv395EwZyVpuo0hYobx-S1RArPow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 3, 2014 at 10:26 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Oct 31, 2014 at 6:44 PM, Geoff Levand <geoff@infradead.org> wrote:
>> On Fri, 2014-10-24 at 13:27 +0100, Mark Rutland wrote:
>> Current user space kexec utilities use /proc/device-tree and nothing
>> else.  The intension of the device tree is to describe the system
>> sufficiently for a kernel to boot, so I think we should put the
>> /memreserve/ info into /proc/device-tree.
>>
>> We could put the /memreserve/ entries in there directly, or convert
>> to reserved-memory nodes.  At the moment I like the idea to convert to
>> reserved-memory nodes.
>
> I'm just wondering does UEFI being used for the memory information
> have any impact here as the DT would not have valid memory nodes
> either? I'd assume reserved memory comes from UEFI (or both) in that
> case?

It should, but as always the answer is not simple. UEFI+DT, it may be
that a CMA region is specified in /reserved-memory and we would want
to respect that, even when getting memory information from UEFI.

However, the /memreserve/ section shouldn't be an issue in this case.
Anything firmware needs protected must be reflected in the UEFI memory
map.

g.
