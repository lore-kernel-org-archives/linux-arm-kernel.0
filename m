From: peda@axentia.se (Peter Rosin)
Date: Thu, 19 Apr 2018 18:40:01 +0200
Subject: [PATCH v2 3/6] drm: of: introduce drm_of_media_bus_fmt
In-Reply-To: <CAL_JsqL1=fzTb5dUgrj07Jv3r026ndsU2o=Nr2eft-bni5jueQ@mail.gmail.com>
References: <20180417131052.16336-1-peda@axentia.se>
 <20180417131052.16336-4-peda@axentia.se>
 <CAL_JsqL1=fzTb5dUgrj07Jv3r026ndsU2o=Nr2eft-bni5jueQ@mail.gmail.com>
Message-ID: <3181dfde-cd19-41a1-6e6d-5be7a9e40674@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-19 18:22, Rob Herring wrote:
> On Tue, Apr 17, 2018 at 8:10 AM, Peter Rosin <peda@axentia.se> wrote:
>> Add a central function to parse a node according to the video
>> interface binding and get a media bus format.
>>
>> Start with only supporting a very limited set of a few basic media
>> bus formats.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/drm_of.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  include/drm/drm_of.h     |  7 +++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
>> index 4c191c050e7d..f9473edb60a7 100644
>> --- a/drivers/gpu/drm/drm_of.c
>> +++ b/drivers/gpu/drm/drm_of.c
>> @@ -212,6 +212,44 @@ int drm_of_encoder_active_endpoint(struct device_node *node,
>>  EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
>>
>>  /*
>> + * drm_of_media_bus_fmt - return the media bus format described in the node
>> + * @node: device tree node containing the media bus format
>> + *
>> + * @node is presumably an of-graph endpoint node.
>> + *
>> + * Return the media bus format, or zero if none is described. Or one of the
>> + * standard error codes.
>> + */
>> +int drm_of_media_bus_fmt(struct device_node *node)
> 
> Should use endpoint or ep here instead of node to be clear what node
> this function operates on.

I just sent v3 and missed this. Anyway, the reason I didn't use ep,
was that you at one point said "port of endpoint", and I wanted this
function to cover both cases. And maybe others. Anyway, if I hear
nothing I'll make the change to ep and I'll also reword the comment
to talk more decisively about endpoints for v4.

Cheers,
Peter
