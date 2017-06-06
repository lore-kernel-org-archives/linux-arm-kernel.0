From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Tue, 6 Jun 2017 22:34:20 +0200
Subject: [PATCH 0/4] [media] davinci: vpif_capture: raw camera support
In-Reply-To: <20170602213431.10777-1-khilman@baylibre.com>
References: <20170602213431.10777-1-khilman@baylibre.com>
Message-ID: <519d0131-b9a7-4afa-78d4-8bb6dccec1ad@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 02/06/17 23:34, Kevin Hilman wrote:
> This series fixes/updates the support for raw camera input to the VPIF.
> 
> Tested on da850-evm boards using the add-on UI board.  Tested with
> both composite video input (on-board tvp514x) and raw camera input
> using the camera board from On-Semi based on the aptina,mt9v032
> sensor[1], as this was the only camera board with the right connector
> for the da850-evm UI board.
> 
> Verified that composite video capture is still working well after these
> updates.

Can you rebase this patch series against the latest media master branch?

Mauro merged a lot of patches, in particular the one switching v4l2_of_ to
v4l2_fwnode_. And that conflicts with patches 2 and 4.

Thanks!

	Hans

> 
> [1] http://www.mouser.com/search/ProductDetail.aspx?R=0virtualkey0virtualkeyMT9V032C12STCH-GEVB
> 
> Kevin Hilman (4):
>   [media] davinci: vpif_capture: drop compliance hack
>   [media] davinci: vpif_capture: get subdevs from DT when available
>   [media] davinci: vpif_capture: cleanup raw camera support
>   [media] davinci: vpif: adaptions for DT support
> 
>  drivers/media/platform/davinci/vpif.c         |  49 +++++-
>  drivers/media/platform/davinci/vpif_capture.c | 224 +++++++++++++++++++++++---
>  drivers/media/platform/davinci/vpif_display.c |   5 +
>  include/media/davinci/vpif_types.h            |   9 +-
>  4 files changed, 263 insertions(+), 24 deletions(-)
> 
