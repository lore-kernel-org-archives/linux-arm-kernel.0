From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Mar 2017 17:28:46 -0500
Subject: [PATCH] Documentation: dt: Add binding for
 /secure-chosen/stdout-path
In-Reply-To: <e3e007ef9ee6a622ae4ccc74fd0fca32b3c5dfb5.1488531370.git.jerome.forissier@linaro.org>
References: <e3e007ef9ee6a622ae4ccc74fd0fca32b3c5dfb5.1488531370.git.jerome.forissier@linaro.org>
Message-ID: <20170330222845.ewddsnmkxwrsposl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 10:24:33AM +0100, Jerome Forissier wrote:
> Some platforms may use a single device tree to describe two address
> spaces, as described in d9f43babb998 ("Documentation: dt: Add bindings
> for Secure-only devices"). For these platforms it makes sense to define
> a secure counterpart of /chosen, namely: /secure-chosen. This new node
> is meant to be used by the secure firmware to pass data to the secure
> OS. Only the stdout-path property is supported for now.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/secure.txt | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> v2
> 
> - Clarify the expected behavior when /secure-chosen/stdout-path is not
> present (either the property or the node itself), as proposed by Peter
> and Robin. Note that I have made the fallback to /chosen optional.

I'm okay with this, but would like to hold off merging it until your are 
really using it. You did say you were "experimenting" and it doesn't 
sound like the DT usage in secure world is that far along. I just want 
to see if there are other issues that come up.

Rob
