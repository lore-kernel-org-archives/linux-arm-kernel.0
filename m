From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Aug 2017 18:12:20 +0800
Subject: [GIT PULL] Allwinner fixes for 4.13 round 2
In-Reply-To: <CAK8P3a3Hokuu6GDj8HQ9-XEBvErcZsJcF6mwGVHo2nUR7SxawA@mail.gmail.com>
References: <20170818040447.ddz27hm3c2eashjr@wens.csie.org>
 <CAK8P3a3Hokuu6GDj8HQ9-XEBvErcZsJcF6mwGVHo2nUR7SxawA@mail.gmail.com>
Message-ID: <CAGb2v67ceJheg1n_U29DmGe7iZ76W=qLdukZJchD=xyvUsenkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 5:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Aug 18, 2017 at 6:04 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> Hi Arnd, Olof,
>>
>> This is the second batch of fixes for 4.13. This is based on the first
>> batch of fixes that was already merged.
>
> Pulled into fixes, thanks!
>
>> We still have some device tree binding changes for the H3 EMAC and
>> integrated Ethernet PHY we need to sort out for 4.13. If it is not
>> done by next week, I will send out revert patches for the driver,
>> device tree binding, and device tree changes. Or is this cutting
>> it too close and we should just revert them now?
>
> I need more information about the specific change to answer that.

The hardware in question has an integrated PHY in the SoC, but can
also choose to use an external PHY. The changes would address two
issues: a) how to differentiate internal vs external PHY in the
device tree, and b) avoiding confusion when both are present and
assigned the same address (there is a mux in the hardware).

> Can you point me to the patches in question?

Here's v2 (which is not final):

    https://www.spinics.net/lists/arm-kernel/msg601325.html

Rob also chimed in on related patches:

    https://www.spinics.net/lists/arm-kernel/msg601482.html
    https://www.spinics.net/lists/devicetree/msg190976.html

ChenYu
