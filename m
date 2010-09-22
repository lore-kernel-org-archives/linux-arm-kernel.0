From: gdavis@mvista.com (George G. Davis)
Date: Wed, 22 Sep 2010 11:56:34 -0400
Subject: mpcore_wdt A9 questions
In-Reply-To: <99c9a321-49a1-42da-b49f-5cdd5c03e17a@SG2EHSMHS008.ehs.local>
References: <1274090044-10236-1-git-send-email-viresh.kumar@st.com>
	<AANLkTil2PtnsKdAHvW5-1WMQyTj6v3uLtrn2CNaZSXkc@mail.gmail.com>
	<4BF12767.4010402@st.com>
	<AANLkTikCC108eWniEBwzYsbkEUYQocICaLtd7FD_vMQ1@mail.gmail.com>
	<20100518132050.GA8748@mvista.com> <4BF362F1.5070100@st.com>
	<AANLkTinQ34da0F0Xp_Rqh0F8fbh0lbSmD2Q68RLNDlIC@mail.gmail.com>
	<99c9a321-49a1-42da-b49f-5cdd5c03e17a@SG2EHSMHS008.ehs.local>
Message-ID: <20100922155634.GQ3555@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello John,

On Wed, Sep 22, 2010 at 09:36:52AM -0600, John Linn wrote:
> Hi,
> 
> The A9 has a watchdog timer per CPU, but I don't see a way to use more
> than one watchdog timer (one for each CPU) using the mpcore_wdt driver.
> 
> I tried to do my research but maybe I missed something. Is this a
> limitation of watchdog timers in Linux or just this driver?

It's not strictly a limitation in the watchdog subsystem, I suspect
it just not something that anyone has needed thus far.  Anyway,
here's something I was working on for upstream which adds support
for all MPCore watchdog timers.  N.B. This is based on v2.6.34 give or
take, not sure if it applies to current.  It still has issues with
per-cpu interrupts but interrupts aren't currently used, so...
