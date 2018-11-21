From: lyude@redhat.com (Lyude Paul)
Date: Wed, 21 Nov 2018 13:56:24 -0500
Subject: [PATCH 6/9] drm: remove deprecated
 "drm_connector_[un]reference" functions
In-Reply-To: <20181115221634.22715-7-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-7-greenfoo@gluegarage.com>
Message-ID: <db5924d66229bd8b50e44395ace64ae2293fa78d.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2018-11-15 at 23:16 +0100, Fernando Ramos wrote:
> There are no more places where this (deprecated) function is being
> used from, thus it can now be removed.
> 
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
> ---
>  include/drm/drm_connector.h | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 9ccad6b062f2..b91b206f1665 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1191,30 +1191,6 @@ static inline void drm_connector_put(struct
> drm_connector *connector)
>  	drm_mode_object_put(&connector->base);
>  }
>  
> -/**
> - * drm_connector_reference - acquire a connector reference
> - * @connector: DRM connector
> - *
> - * This is a compatibility alias for drm_connector_get() and should not be
> - * used by new code.
> - */
> -static inline void drm_connector_reference(struct drm_connector *connector)
> -{
> -	drm_connector_get(connector);
> -}
> -
> -/**
> - * drm_connector_unreference - release a connector reference
> - * @connector: DRM connector
> - *
> - * This is a compatibility alias for drm_connector_put() and should not be
> - * used by new code.
> - */
> -static inline void drm_connector_unreference(struct drm_connector
> *connector)
> -{
> -	drm_connector_put(connector);
> -}
> -
>  /**
>   * drm_connector_is_unregistered - has the connector been unregistered from
>   * userspace?
-- 
Cheers,
	Lyude Paul
