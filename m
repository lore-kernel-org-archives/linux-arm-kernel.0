From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 16 Oct 2015 08:27:01 -0500
Subject: [RFC 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <20151016130632.GE2054@leverpostej>
References: <1444997709-57293-1-git-send-email-ck.hu@mediatek.com>
 <1444997709-57293-2-git-send-email-ck.hu@mediatek.com>
 <20151016130632.GE2054@leverpostej>
Message-ID: <CAL_JsqJvmK-3+DFTHQEEjJuj6N_PCXbEGa1CVu9-yF3s+HKGfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 8:06 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> +     /* FIXME - use of_graph_get_port_by_id(np, 1) on newer kernels */
>> +     in_ep = of_graph_get_next_endpoint(np, NULL);
>
> Huh?
>
>> +     edidp = of_get_property(np, "edid", &size);
>
> This property wasn't mentioned in the binding document.
>
> Please describe it. If it's from a more generic binding, refer to that
> from the binding document.

It should be generic, but currently documented in individual drivers.
I also think this is not the right location in the DT for this
property. It should be part of the panel or connector node instead.

Rob
