From: robh@kernel.org (Rob Herring)
Date: Wed, 23 Mar 2016 10:20:52 -0500
Subject: [PATCH v3 2/2] documentation: Fix pinctrl documentation for
 Meson8 / Meson8b
In-Reply-To: <1458724440-32228-3-git-send-email-carlo@caione.org>
References: <1458724440-32228-1-git-send-email-carlo@caione.org>
 <1458724440-32228-3-git-send-email-carlo@caione.org>
Message-ID: <20160323152052.GA20906@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 10:14:00AM +0100, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Fix pin controller documentation introducing the new compatibles for
> the pinctrl drivers specific for aobus / cbus.
> 
> This is needed because we have changed the pin controller driver: we
> have now a single specialized pinctrl driver / compatible for each bus
> the controller is attached to, instead of one single driver dealing with
> all the controllers we have on different buses.

Aren't you breaking compatibility with old DTs here? If so, you need to 
be clear that you are and why you think that is okay.
 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  .../devicetree/bindings/pinctrl/meson,pinctrl.txt  | 38 ++++------------------
>  1 file changed, 7 insertions(+), 31 deletions(-)
