From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 8 Feb 2018 14:54:30 +0100
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <1517939104-230881-6-git-send-email-john.garry@huawei.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
Message-ID: <20180208135430.GD10234@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:

SNIP

> @@ -940,6 +1090,7 @@ int main(int argc, char *argv[])
>  	const char *output_file;
>  	const char *start_dirname;
>  	struct stat stbuf;
> +	struct event_struct *es1, *es2;
>  
>  	prog = basename(argv[0]);
>  	if (argc < 4) {
> @@ -984,17 +1135,28 @@ int main(int argc, char *argv[])
>  
>  	maxfds = get_maxfds();
>  	mapfile = NULL;
> +	rc = nftw(ldirname, preprocess_arch_std_files, get_maxfds(), 0);

you could use maxfds variable in here

jirka
