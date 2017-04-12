From: olivier.moysan@st.com (Olivier MOYSAN)
Date: Wed, 12 Apr 2017 08:30:31 +0000
Subject: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
In-Reply-To: <20170411211040.htrcedus3c57fbed@sirena.org.uk>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
 <20170411211040.htrcedus3c57fbed@sirena.org.uk>
Message-ID: <86a179ad-7961-18f7-8050-25e0e584c77d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 04/11/2017 11:10 PM, Mark Brown wrote:
> On Tue, Apr 11, 2017 at 03:44:52PM +0000, Olivier MOYSAN wrote:
>
>> However, regarding STM32 I2S driver, I'm wondering if selecting DAI
>> is the best way to configure interface as tx, rx or fd.
>
> Why do you even need to configure this?
>

The IP provides two data wires, SD in and SD out. So it can be 
configured either as capture or playback only, or full-duplex.
This corresponds to a mode selection through a register configuration.

>> Maybe, it is more relevant to configure DAI according to DMA
>> configuration from I2S node.
>> This would moreover avoid to allocate 2 dmas channels when not
>> necessary (tx or rx only).
>> If you agree with this, I will implement this change in a v2.
>
> That sounds wrong, I'd expect this wiring to be done statically as part
> of the .dtsi for the SoC (or just grabbed as needed at runtime if
> things are flexbile enough) rather than being a configuration thing done
> per board...  I had thought that this was configuration reflecting
> different ways of taping out the IP with different feature sets, is that
> not the case?
>

This configuration is board dependent. The IP may be used as rx, tx or 
fd depending on board. So I think it can make sense to have a DMA 
configuration linked to board, and to set IP mode accordingly.

BRs
olivier
