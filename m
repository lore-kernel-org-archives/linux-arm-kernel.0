From: jassisinghbrar@gmail.com (jassi brar)
Date: Mon, 15 Mar 2010 13:47:22 +0900
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <4B9DB823.1040809@st.com>
References: <4B9DB823.1040809@st.com>
Message-ID: <1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 1:31 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
> In our SOC's (SPEArxxx), we have many peripheral sharing PL_GPIO pins and so
> only few peripherals can be selected in a configuration. This is configurable
> using a set of registers. Now the problem is to make following work:
>
> 1. How to do this selection in kernel in a simple way?
> 2. Based on this selection hardware registers needs to be configured.
Why can't you make the drivers acquire and setup the necessary pins during
probe?
Among other benefits, it enables you to use the same kernel image and device
drivers as modules -- if a GPIO can be used by two different device
controllers, you
can switch the 'mode' of the board by simple rmmod-insmod
