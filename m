From: david@lechnology.com (David Lechner)
Date: Wed, 2 Nov 2016 16:38:24 -0500
Subject: [PATCH 1/3] ARM: davinci: da8xx: Fix ohci driver name
In-Reply-To: <20161102124435.31777-2-ahaslam@baylibre.com>
References: <20161102124435.31777-1-ahaslam@baylibre.com>
 <20161102124435.31777-2-ahaslam@baylibre.com>
Message-ID: <e819cbfc-e2e6-ccc0-1178-cfe5a85098a8@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2016 07:44 AM, Axel Haslam wrote:
> There is a single instance of the ohci driver,
> while the clk lookup table is making reference to "ohci"
> other subsystems (such as phy) are looking for "ohci.0"
>

This patch changes the "device" name, not the "driver" name. You use 
"driver" above and in the subject.

> Since there is a single ohci instance, change the dev id
> to -1, and add the "-da8xx" for consitancy with the musb
> driver name.

It would be more accurate to say that you are adding "-da8xx" because 
you are also changing the ohci _driver_ name in a separate patch.

>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
