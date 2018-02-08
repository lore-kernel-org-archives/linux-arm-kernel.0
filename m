From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 8 Feb 2018 14:55:19 +0100
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <1517939104-230881-6-git-send-email-john.garry@huawei.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
Message-ID: <20180208135519.GH10234@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:

SNIP

>  	rc = nftw(ldirname, process_one_file, maxfds, 0);
>  	if (rc && verbose) {
>  		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
> -		goto empty_map;
> +		goto free_standard_arch_events;
>  	} else if (rc < 0) {
>  		/* Make build fail */
>  		return 1;
> -	} else if (rc) {
> -		goto empty_map;
>  	}

please put this change into separate patch

thanks,
jirka
