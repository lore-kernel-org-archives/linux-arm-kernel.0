From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 9 Jun 2017 16:05:10 -0700
Subject: [PATCH v2 2/2] ARM: dts: da850-evm: drop VPIF endpoints
In-Reply-To: <b659fcf2-518a-4c1a-4989-d53dfc951ff2@lechnology.com>
References: <20170609172111.23057-1-khilman@baylibre.com>
 <20170609172111.23057-3-khilman@baylibre.com>
 <b659fcf2-518a-4c1a-4989-d53dfc951ff2@lechnology.com>
Message-ID: <CAOi56cVWwCLjzL6c0VGv+k0geEsvj22hS8-fz_15YT2ikYsf5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Fri, Jun 9, 2017 at 2:17 PM, David Lechner <david@lechnology.com> wrote:
> On 06/09/2017 12:21 PM, Kevin Hilman wrote:
>>
>> Drop the unused endpoints.  They should only be used when there is
>> an actual remote-endpoint connected.
>>
>
> Would it make sense to implement the status property here instead of
> removing the nodes completely? If other property values are the same for all
> users, then it seems like making all users have to dig up the docs and
> copy/paste is not as nice as just overriding the status property. But, if
> users have to change other values as well, then it makes sense to just
> delete these.

I considered that, but in reality, when adding an endpoint for VPIF
input, you'll not only need to add the remote-endpoint, but the
bus_width will depend on the remote-endpoint as well (e.g. tvp514x for
composite only uses 8-bit bus, but for raw-camera capture, it can use
10 or 12.)

Therefore, I think it best to delete them entirely.

Thanks for the review,

Kevin
