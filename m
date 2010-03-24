From: andy@warmcat.com (Andy Green)
Date: Wed, 24 Mar 2010 12:50:46 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <005501cacb42$c5bbcde0$513369a0$%szyprowski@samsung.com>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>	<4BA9D93E.50705@warmcat.com>
	<005501cacb42$c5bbcde0$513369a0$%szyprowski@samsung.com>
Message-ID: <4BAA0AA6.80902@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/10 11:11, Somebody in the thread at some point said:

Hi -

> Right, this is a really common case. Maybe this callback could be added
> to the regulator framework as well?
>
> On the other hand a more generic solution might be needed, because besides
> the PMU there might be some other dependences between various devices that
> not possible to be ensured in the current framework (I'm thinking of v4l2
> subdevs that link 2 separate devices together, but currently are used only
> with i2c clients).

Right, it's a generic issue with needing to delay other device 
registration until something else has completed probe, not just PMU. 
PMU is just the most common parent.

A callback is needed after probe() returned without error somehow.

-Andy
