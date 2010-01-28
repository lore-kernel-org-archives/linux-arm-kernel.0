From: t.fujak@samsung.com (Tomasz Fujak)
Date: Thu, 28 Jan 2010 10:34:20 +0100
Subject: [PATCH/RFC v2 0/3] Human readable platform-specific performance event
	support
Message-ID: <1264671263-21412-1-git-send-email-t.fujak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Human readable description support for performance events v2. With perf support included.
Changes from v1:
 - applied on top of latest perf_event/ARM (5899/1 - 5903/1)
 - moved to debugfs, now based on seq_file
 - reads one line at a time, memory overallocation fixed [perf]

The following patches provide a sysfs entry with hardware event human readable description in the form of "0x%llx\t%lld-%lld\t%s\t%s" % (event_value, minval, maxval, name, description) and means to populate the file.
The version posted contains ARMv6, ARMv7 (Cortex-A[89]) support in this matter.

The intended use is twofold: for users to read the list directly and for tools (like perf).

This series includes:

[PATCH/RFC v2 1/3] perfevents: Added performance event structure definition, export event description in the debugfs "perf_events_platform" file
[PATCH/RFC v2 2/3] [ARM] perfevents: Event description for ARMv6, Cortex-A8 and Cortex-A9 exported
[PATCH/RFC v2 3/3] perf: Extended events (platform-specific) support in perf

Thanks,
-- 
Tomasz Fujak
