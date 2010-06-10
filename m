From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Thu, 10 Jun 2010 16:12:43 -0500
Subject: facing undefined inconsistent cache issues on cortex-a9
In-Reply-To: <4C0905BC.1090301@st.com>
References: <4BF9F5FB.6020306@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C57001F3@dbde02.ent.ti.com>
	<4BFBBD83.5080302@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C57A5FC6@dbde02.ent.ti.com>
	<13B9B4C6EF24D648824FF11BE896716203BB37005A@dlee02.ent.ti.com>
	<4C0905BC.1090301@st.com>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203BB762EB0@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Shiraz HASHIM [mailto:shiraz.hashim at st.com]
> Sent: Friday, June 04, 2010 8:55 AM
> To: Woodruff, Richard

> thanks for your inputs. We have some updates in this regard.
> In our architecture we have 2 ports coming out of the A9SM (multi core cortex)
> block to the interconnect matrix and the transfers are distributed between
> them.
>
> When we used the address filtering option of SCU to divide and mutually
> exclude
> the traffic between port0 and port1 of A9SM(multi core cortex) block. Like,
> assigning 1 half of the address space to port 1 and rest goes through port0.
> This solved the problem with the same set of cache and other system
> configurations.
> We are not using L2 cache and it is kept disabled. The SCU also is only used
> for
> address filtering and its synchronisation function is disabled (as we are not
> bringing up the second core)
> Now, we are not able to understand what it means. Do we need to divide the
> traffic between ports as described and it is normal. Or there is some problem
> in
> the way the transfers are handled in the system.

Off hand I'm not sure of the right answer.  The design I'm working on does not require the filtering feature so I've not looked much at it outside of some errata.  I am aware of another design which accesses a bit larger address space which does use filtering.

I'd guess you need to understand your cortex-memmap + AXI-to-memory bus adapter characteristics.

Regards,
Richard W.
