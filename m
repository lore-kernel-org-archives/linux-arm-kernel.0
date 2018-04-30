From: peda@axentia.se (Peter Rosin)
Date: Mon, 30 Apr 2018 23:12:56 +0200
Subject: [PATCH 24/24] drm/bridge: establish a link between the bridge
 supplier and consumer
In-Reply-To: <20180430153236.GP12521@phenom.ffwll.local>
References: <20180426223139.16740-1-peda@axentia.se>
 <20180426223139.16740-25-peda@axentia.se>
 <20180430153236.GP12521@phenom.ffwll.local>
Message-ID: <e2562f6f-f7b0-477c-db38-a3bf6c956fa7@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-30 17:32, Daniel Vetter wrote:
> On Fri, Apr 27, 2018 at 12:31:39AM +0200, Peter Rosin wrote:
>> If the bridge supplier is unbound, this will bring the bridge consumer
>> down along with the bridge. Thus, there will no longer linger any
>> dangling pointers from the bridge consumer (the drm_device) to some
>> non-existent bridge supplier.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Minus the ->owner bikeshed I brought up in the previous patch I agree with
> this approach as the best way to move forward for now.
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks, let's see if Laurent is also on-board...

> One small suggestion below, for merging I'd say pls get Jyri's
> review/tested-by too, since you're both working on the same problem it
> seems.

Yes, I too would be very happy to see a tested-by from someone.

> Aside: Do you want commit rights to drm-misc to be able to push work like
> this?

If that makes life easier, sure.

Cheers,
Peter
