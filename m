From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 21 Jul 2016 09:47:11 +0200
Subject: [PATCH V2 3/6] perf tools: add infrastructure for PMU specific
 configuration
In-Reply-To: <1469047100-18131-4-git-send-email-mathieu.poirier@linaro.org>
References: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
 <1469047100-18131-4-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160721074711.GA7192@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 02:38:17PM -0600, Mathieu Poirier wrote:
> This patchset adds PMU driver specific configuration to the parser
> infrastructure by preceding any term with the '@' letter.  As such
> doing something like:
> 
> perf record -e some_event/@cfg1, at cfg2=config/ ...
> 
> will see 'cfg1' and 'cfg2=config' being added to the list of evsel config
> terms.  Token 'cfg1' and 'cfg2=config' are not processed in user space
> and are meant to be interpreted by the PMU driver.

please also update the docs, like 'Documentation/perf-record.txt --event option'

thanks,
jirka
