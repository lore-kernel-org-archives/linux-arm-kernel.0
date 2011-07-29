From: viresh.linux@gmail.com (viresh kumar)
Date: Fri, 29 Jul 2011 08:30:54 -0700
Subject: [PATCH 09/18] dmaengine/amba-pl08x: Schedule tasklet in case of
	error interrupt
In-Reply-To: <1311941799.1536.532.camel@vkoul-udesk3>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<9c81beb9cd84f84b58abbd24ebfae85dfe8d8ee1.1311936524.git.viresh.kumar@st.com>
	<1311941799.1536.532.camel@vkoul-udesk3>
Message-ID: <CAOh2x==_g+JQzTizgVTdH8Dyg_5+KpyYm+G_Ddu5mO15N6n-tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/29/11, Koul, Vinod <vinod.koul@intel.com> wrote:
> On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
>> +		dev_err(&pl08x->adev->dev, "%s error interrupt, register value"
>> +				"0x%08x\n", __func__, err);
> again this looks convoluted, and the stuff is quotes can be in single
> line :)

Will take care of this in all patches.

> but in tasklet you will call the client callback, so how does the client
> know if this was success or error? Did I miss anything?

No you didn't. I couldn't find a way in framework to report back to
client success or failure.
Is there any way? For now i have only kept error prints.

--
viresh
