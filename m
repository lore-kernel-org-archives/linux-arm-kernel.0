From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 6 Oct 2010 09:28:24 +0530
Subject: [PATCH V2 21/69] Keyboard: Adding support for spear-keyboard
In-Reply-To: <20101005154737.GA19730@core.coreip.homeip.net>
References: <cover.1285933331.git.viresh.kumar@st.com>
	<584e4ecc7883807e1fae0e6c53b2837954935e53.1285933331.git.viresh.kumar@st.com>
	<20101005154737.GA19730@core.coreip.homeip.net>
Message-ID: <4CABF3E0.8010909@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2010 09:17 PM, Dmitry Torokhov wrote:
> As discussed previously I'd like to see the driver using as much of
> matrix_keypad infrastructure as practical and also to see the initial
> keypad copied into the spear_kbd structure to ensure that the board code
> could be made const and bind/rebind of the device would restore the
> original keymap.
> 

Dmitry,

As suggested in V1, we have used KEY() macro from matrix_keypad.h file.
Also we are allocating memory for keymap in driver itself in probe.
Then we are copying keymap in from plat data. This makes it restore to
original keymap on every bind/rebind of device.

Is there anything else we need to do??

-- 
viresh
