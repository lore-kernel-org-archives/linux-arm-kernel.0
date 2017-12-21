From: olivier.moysan@st.com (Olivier MOYSAN)
Date: Thu, 21 Dec 2017 10:51:39 +0000
Subject: [RFC PATCH 2/2] ASoC: select sysclk clock from mlck clock
 provider in wm8994 driver
In-Reply-To: <20171220155000.GD17890@sirena.org.uk>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
 <20171214173624.GM9788@sirena.org.uk>
 <43426b67-3546-8422-7fcb-9fa1ff192679@st.com>
 <20171219093506.GD8563@sirena.org.uk>
 <c51bf5a8-27f7-6d76-f4fb-c8884387bdca@st.com>
 <20171220155000.GD17890@sirena.org.uk>
Message-ID: <f20b40e9-6e6b-636f-367a-2bad6ea48b18@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 12/20/2017 04:50 PM, Mark Brown wrote:
> On Wed, Dec 20, 2017 at 12:42:10PM +0000, Olivier MOYSAN wrote:
> 
>> As a generic machine, simple or audio graph cards are not able to manage
>> codec clock muxing.
>> If we exclude the management of muxing through codec controls,
>> the remaining solution is to handle it fully through clock framework.
>> The current patch only supports a limited range of muxing capabilities
>> of the codec.
>> To have a full management of the muxing, I think it is necessary to add
>> a device tree node for each codec interface and to define an aif clock
>> in these nodes.
>> Then parent clock assignment of these aif clocks would allow to handle
>> the muxing.
> 
> Controlling clocking through a clock API binding would be good, yes.
> That'd solve a bunch of other problems with use of multi-purpose clocks
> for audio as well.
> 

Thanks for your feedback. I will implement this in a patch v2.

BRs
